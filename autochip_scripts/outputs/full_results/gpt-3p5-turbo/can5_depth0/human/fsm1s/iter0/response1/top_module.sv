module top_module (
	input clk,
	input in,
	input reset,
	output out
);
    reg [1:0] state;
    
    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 2'b10; // B state
        else begin
            case (state)
                2'b10: begin // B state
                    if (in)
                        state <= 2'b10; // B state
                    else
                        state <= 2'b01; // A state
                end
                2'b01: begin // A state
                    if (in)
                        state <= 2'b01; // A state
                    else
                        state <= 2'b10; // B state
                end
                default: state <= 2'b10; // B state (default for safety)
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b10: out = 1'b1; // B state
            2'b01: out = 1'b0; // A state
            default: out = 1'b1; // B state (default for safety)
        endcase
    end
    
endmodule
