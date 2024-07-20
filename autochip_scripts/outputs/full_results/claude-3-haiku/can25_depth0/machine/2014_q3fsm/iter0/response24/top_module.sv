module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// State registers
reg [3:0] state;
parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, 
          S10 = 4'b0011, S11 = 4'b0100, S20 = 4'b0101, 
          S21 = 4'b0110, S22 = 4'b0111;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: if (s) state <= B;
            B: if (w) state <= S11; else state <= S10;
            C: if (w) state <= S11; else state <= S10;
            S10: if (w) state <= S21; else state <= S20;
            S11: if (w) state <= S22; else state <= S21;
            S20: state <= B;
            S21: if (w) state <= C; else state <= B;
            S22: if (w) state <= B; else state <= C;
        endcase
    end
end

// Output logic
always @(*) begin
    case (state)
        S20, S21, S22: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
