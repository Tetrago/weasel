typedef enum logic [3:0] {
  ALU_OP_ADD,
  ALU_OP_OR,
  ALU_OP_AND,
  ALU_OP_XOR,
  ALU_OP_NOT,
  ALU_OP_NEG,
  ALU_OP_ASR,
  ALU_OP_LSL
} alu_operation_e;

module alu #(
    parameter int Width = 16
) (
    input wire signed [Width-1:0] a_i,
    input wire signed [Width-1:0] b_i,
    input alu_operation_e op_i,
    output wire signed [Width-1:0] result_o
);
  always_comb begin
    case (op_i)
      ALU_OP_ADD: result_o = a_i + b_i;
      ALU_OP_OR: result_o = a_i | b_i;
      ALU_OP_AND: result_o = a_i & b_i;
      ALU_OP_XOR: result_o = a_i ^ b_i;
      ALU_OP_NOT: result_o = ~a_i;
      ALU_OP_NEG: result_o = -a_i;
      ALU_OP_ASR: result_o = a_i >>> b_i;
      ALU_OP_LSL: result_o = a_i << b_i;
      default: result_o = 0;
    endcase
  end
endmodule
