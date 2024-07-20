module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg [5:0] counter;
    
    parameter IDLE = 3'd0;
    parameter FLAG1 = 3'd1;
    parameter FLAG2 = 3'd2;
    parameter ERROR = 3'd3;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the state and counter
            state <= IDLE;
            counter <= 6'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (in) begin
                        // Transition to the FLAG1 state
                        state <= FLAG1;
                        counter <= counter + 1;
                    end
                end
                
                FLAG1: begin
                    if (in) begin
                        // Transition to the FLAG2 state
                        state <= FLAG2;
                        counter <= counter + 1;
                    end else begin
                        // Transition back to the IDLE state
                        state <= IDLE;
                        counter <= 6'b0;
                    end
                end
                
                FLAG2: begin
                    if (in) begin
                        // Transition to the ERROR state
                        state <= ERROR;
                        counter <= counter + 1;
                    end else begin
                        // Transition back to the IDLE state
                        state <= IDLE;
                        counter <= 6'b0;
                        // Assert the flag signal
                        flag <= 1'b1;
                    end
                end
                
                ERROR: begin
                    if (!in) begin
                        // Transition back to the IDLE state
                        state <= IDLE;
                        counter <= 6'b0;
                        // Assert the error signal
                        err <= 1'b1;
                    end else begin
                        // Continue counting consecutive 1s
                        counter <= counter + 1;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the output signals
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    // No action needed
                end
                
                FLAG1: begin
                    // No action needed
                end
                
                FLAG2: begin
                    // No action needed
                end
                
                ERROR: begin
                    if (counter == 6'd5) begin
                        // Assert the discard signal
                        disc <= 1'b1;
                    end
                end
            endcase
        end
    end
    
endmodule
