module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

// Define state encoding
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// State transition logic
always @* begin
    case (state)
        A: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
        C: begin
            if (in) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        D: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
        default: begin
            next_state = A; // Default case
        end
    endcase
end

// Output logic
always @* begin
    case (state)
        D: begin
            out = 1;
        end
        default: begin
            out = 0; // Default case
        end
    endcase
end

endmodule
