module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Create states enumeration
    typedef enum logic [1:0] {
        BYTE1,
        BYTE2,
        BYTE3,
        DONE
    } state_t;

    // Declare state variable and initialize to BYTE1
    state_t state = BYTE1;
    
    // Declare temporary signal to store the third bit of the input
    wire third_bit = in[2];
    
    // State machine logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1; // Reset state to BYTE1
            done <= 0;      // Reset done signal
        end else begin
            case (state)
                BYTE1: begin
                    if (third_bit) begin
                        state <= BYTE2;
                    end
                end
                BYTE2: begin
                    state <= BYTE3;
                end
                BYTE3: begin
                    state <= DONE;
                end
                DONE: begin
                    if (third_bit) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
                end
            endcase
        end
    end
    
    // Assign done signal
    assign done = (state == DONE);
    
endmodule
