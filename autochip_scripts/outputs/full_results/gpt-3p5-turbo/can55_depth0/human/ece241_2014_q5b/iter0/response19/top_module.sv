module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;

// Define internal signals
reg [1:0] state, next_state;
reg z_out;

// Assign initial state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// State transition logic
always @(state, x) begin
    case (state)
        A: begin
            if (x) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (x) begin
                next_state = B;
            end else begin
                next_state = B;
            end
        end
        default: next_state = A;
    endcase
end

// Output logic
always @(state, x) begin
    case (state)
        A: z_out = 1'b0;
        B: z_out = 1'b1;
        default: z_out = 1'b0;
    endcase
end

// Assign output signals
assign z = z_out;

endmodule
