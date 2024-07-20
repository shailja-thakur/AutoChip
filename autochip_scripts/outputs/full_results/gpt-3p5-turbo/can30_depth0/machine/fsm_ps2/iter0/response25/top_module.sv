module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
    reg [2:0] state; // state register
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // reset to BYTE1 state
        end else begin
            case (state)
                3'b000: begin // BYTE1 state
                    if (in[2] == 1'b0) begin
                        state <= 3'b000; // remain in BYTE1 state
                    end else begin
                        state <= 3'b001; // transition to BYTE2 state
                    end
                end
                
                3'b001: begin // BYTE2 state
                    state <= 3'b010; // transition to BYTE3 state
                end
                
                3'b010: begin // BYTE3 state
                    state <= 3'b011; // transition to DONE state
                end
                
                3'b011: begin // DONE state
                    if (in[2] == 1'b0) begin
                        state <= 3'b000; // transition back to BYTE1 state
                    end else begin
                        state <= 3'b001; // transition back to BYTE2 state
                    end
                end
                
                default: begin
                    state <= 3'b000; // default to BYTE1 state
                end
            endcase
        end
    end
    
    assign done = (state == 3'b011); // done signal is asserted when in DONE state

endmodule
