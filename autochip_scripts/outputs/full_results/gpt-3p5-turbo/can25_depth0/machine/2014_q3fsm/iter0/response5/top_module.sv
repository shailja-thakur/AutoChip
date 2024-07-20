module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// State definitions
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

// State register
reg [2:0] state;

// Next state logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                end
            end
            
            B: begin
                if (w) begin
                    state <= S11;
                end else begin
                    state <= S10;
                end
            end
            
            C: begin
                if (w) begin
                    state <= S11;
                end else begin
                    state <= S10;
                end
            end
            
            S10: begin
                if (w) begin
                    state <= S21;
                end else begin
                    state <= S20;
                end
            end
            
            S11: begin
                if (w) begin
                    state <= S22;
                end else begin
                    state <= S21;
                end
            end
            
            S20: begin
                state <= B;
            end
            
            S21: begin
                if (w) begin
                    state <= C;
                end else begin
                    state <= B;
                end
            end
            
            S22: begin
                if (w) begin
                    state <= B;
                end else begin
                    state <= C;
                end
            end
        endcase
    end
end

// Output logic
always @(state) begin
    case (state)
        B, C, S10, S11, S21, S22: begin
            z <= 1'b1;
        end
        default: begin
            z <= 1'b0;
        end
    endcase
end

endmodule
