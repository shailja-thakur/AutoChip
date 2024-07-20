module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state, next_state;
wire [2:0] state;

// State codes:
// A = 3'b000
// B = 3'b001
// C = 3'b010
// D = 3'b011
// E = 3'b100
// F = 3'b101

// Next state logic
always @(state, w) begin
    case (state)
        3'b000: begin
            if (w)
                next_state = 3'b001;
            else
                next_state = 3'b000;
        end
        
        3'b001: begin
            if (w)
                next_state = 3'b010;
            else
                next_state = 3'b011;
        end
        
        3'b010: begin
            if (w)
                next_state = 3'b100;
            else
                next_state = 3'b011;
        end
        
        3'b011: begin
            if (w)
                next_state = 3'b101;
            else
                next_state = 3'b000;
        end
        
        3'b100: begin
            if (w)
                next_state = 3'b100;
            else
                next_state = 3'b011;
        end
        
        3'b101: begin
            if (w)
                next_state = 3'b010;
            else
                next_state = 3'b011;
        end
    endcase
end

// State flip-flops
always @(posedge clk, posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_state;
end

// Output assignment
always @* begin
    case (state)
        3'b100, 3'b101: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
