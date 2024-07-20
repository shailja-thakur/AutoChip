module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;

// Reset state
always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        A: begin
            if (s == 1'b0) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        B: begin
            next_state = A;
        end
        default: begin
            next_state = A;
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    if (reset) begin
        z <= 1'b0;
    end else begin
        case (state)
            A: begin
                z <= 1'b0;
            end
            B: begin
                if (w) begin
                    z <= 1'b1;
                end else begin
                    z <= 1'b0;
                end
            end
            default: begin
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
