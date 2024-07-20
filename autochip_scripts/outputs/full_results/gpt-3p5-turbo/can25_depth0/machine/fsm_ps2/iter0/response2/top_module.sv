module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg done;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000; // Initialize state to BYTE1
        done <= 0;
    end else begin
        case (state)
        
            // BYTE1 state
            3'b000: begin
                if (in[2] == 1) begin
                    state <= 3'b001; // Transition to BYTE2 state
                end else begin
                    state <= 3'b000; // Remain in BYTE1 state
                end
            end
            
            // BYTE2 state
            3'b001: begin
                state <= 3'b010; // Transition to BYTE3 state
            end
            
            // BYTE3 state
            3'b010: begin
                state <= 3'b011; // Transition to DONE state
            end
            
            // DONE state
            3'b011: begin
                if (in[2] == 1) begin
                    state <= 3'b001; // Transition to BYTE2 state
                end else begin
                    state <= 3'b000; // Transition to BYTE1 state
                end
            end
        
        endcase
    end
end

assign done = (state == 3'b011); // Assert done signal when in DONE state

endmodule
