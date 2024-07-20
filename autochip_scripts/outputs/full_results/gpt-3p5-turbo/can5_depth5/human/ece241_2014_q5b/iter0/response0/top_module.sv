module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// States
reg [1:0] state;
parameter A = 2'b00;
parameter B = 2'b01;

// Outputs
reg z;

// Next state and output logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
        z <= 1'b0;
    end else begin
        case(state)
            A: begin
                if (x) begin
                    state <= B;
                    z <= 1'b1;
                end else begin
                    state <= A;
                    z <= 1'b0;
                end
            end
            B: begin
                if (x) begin
                    state <= B;
                    z <= 1'b0;
                end else begin
                    state <= B;
                    z <= 1'b1;
                end
            end
        endcase
    end
end

endmodule
