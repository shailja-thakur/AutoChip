module top_module (
	input clk,
	input in,
	input reset,
	output out
);

    reg [1:0] state;
    reg out;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 2'b00;
        end else begin
            case(state)
                2'b00: begin  // State A
                    if(in)
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                end
                2'b01: begin  // State B
                    if(in)
                        state <= 2'b01;
                    else
                        state <= 2'b10;
                end
                2'b10: begin  // State C
                    if(in)
                        state <= 2'b11;
                    else
                        state <= 2'b00;
                end
                2'b11: begin  // State D
                    if(in)
                        state <= 2'b01;
                    else
                        state <= 2'b10;
                end
                default: state <= 2'b00;
            endcase
        end
    end

    always @(state) begin
        if(state == 2'b11) begin
            out <= 1'b1;
        end else begin
            out <= 1'b0;
        end
    end

endmodule
