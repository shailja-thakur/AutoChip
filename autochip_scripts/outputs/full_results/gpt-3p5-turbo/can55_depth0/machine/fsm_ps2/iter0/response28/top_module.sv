module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Enum to define states
    typedef enum bit [1:0] {BYTE1, BYTE2, BYTE3, DONE} stateType;
    stateType currentState, nextState;

    // Register to hold the current state
    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= nextState;
        end
    end

    always @* begin
        nextState = state;
        done = 0;
        
        case (state)
            BYTE1: begin
                if (in[2] == 1'b1) begin
                    nextState = BYTE2;
                end
            end
            
            BYTE2: begin
                nextState = BYTE3;
            end
            
            BYTE3: begin
                nextState = DONE;
            end
            
            DONE: begin
                if (in[2] == 1'b0) begin
                    nextState = BYTE1;
                end else begin
                    nextState = BYTE2;
                end
                done = 1'b1;
            end
        endcase
    end

endmodule
