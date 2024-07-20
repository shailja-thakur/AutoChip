module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
    // State declaration
    reg [2:0] state;

    // Internal signals
    reg [7:0] byte1;
    reg [7:0] byte2;

    // Output signal
    reg done;

    // Always block to handle state transitions and output generation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initial state
            done <= 0;
        end 
        else begin
            case (state)
                3'b000: begin // Wait for in[3] to be 1
                    if (in[3] == 1'b1) begin
                        state <= 3'b001; // Transition to state 1
                        byte1 <= in;
                    end
                end
                3'b001: begin // Receive byte 2
                    state <= 3'b010; // Transition to state 2
                    byte2 <= in;
                end
                3'b010: begin // Receive byte 3
                    state <= 3'b011; // Transition to state 3
                end
                3'b011: begin // Process and output received message
                    done <= 1; // Set done signal
                    state <= 3'b000; // Transition to state 0
                end
            endcase
        end
    end
endmodule
