module yAlu (z, ex, a, b, op) ;

   input [31:0] a, b;
   input [2:0]  op;
   output [31:0] z;
   output        ex;
   wire          cout;
   wire [31:0]   alu_and, alu_or, alu_arith, slt, tmp;

   // upper bits are always zero
   assign slt[31:1] = 0;

   // not supported
   assign ex = 0;

   // set slt[0]
   xor (condition, a[31], b[31]);
   assign tmp = a - b;
   yMux #(.SIZE(1)) slt_mux(slt[0], tmp[31], a[31], condition);

   // instantiate the components and connect them
   and m_and [31:0] (alu_and, a, b);
   or m_or [31:0] (alu_or, a, b);
   yArith m_arith(alu_arith, cout, a, b, op[2]);
   yMux4to1 #(.SIZE(32)) mux(z, alu_and, alu_or, alu_arith, slt, op[1:0]);

endmodule // yAlu
