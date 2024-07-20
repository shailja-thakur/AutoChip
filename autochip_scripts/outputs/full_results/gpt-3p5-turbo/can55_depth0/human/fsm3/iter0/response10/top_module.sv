module top_module (
    input clk,
    input in,
    input areset,
    output out
);
  
reg [1:0] current_state, next_state;
reg output_reg;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// State transition logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// Output logic
always @(current_state) begin
    case (current_state)
        A: output_reg = 1'b0;
        B: output_reg = 1'b0;
        C: output_reg = 1'b0;
        D: output_reg = 1'b1;
    endcase
end

// Next state logic
always @(current_state, in) begin
    case (current_state)
        A: if (in) next_state = B; else next_state = A;
        B: if (in) next_state = B; else next_state = C;
        C: if (in) next_state = D; else next_state = A;
        D: if (in) next_state = B; else next_state = C;
    endcase
end

assign out = output_reg;

endmodule
