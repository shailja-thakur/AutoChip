module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    reg [2:0] state;
    reg [7:0] data;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            data <= 8'b0;
            done <= 1'b0;
        end else begin
            
            case (state)
                
                3'b000: // IDLE state
                    if (in) begin
                        state <= 3'b001; // Start bit detected, move to next state
                    end
                    
                3'b001: // RECEIVE state
                    if (!in) begin
                        state <= 3'b010; // Start bit ended, move to next state
                    end
                    
                3'b010: // BIT0 state
                    state <= 3'b011; // Move to next state
                    
                3'b011: // BIT1 state
                    state <= 3'b100; // Move to next state
                    
                3'b100: // BIT2 state
                    state <= 3'b101; // Move to next state
                    
                3'b101: // BIT3 state
                    state <= 3'b110; // Move to next state
                    
                3'b110: // BIT4 state
                    state <= 3'b111; // Move to next state
                    
                3'b111: // BIT5 state
                    state <= 3'b010; // Move to next state
                    
            endcase
                
        end
    end
    
    always @(posedge clk) begin
        case (state)
            3'b000: // IDLE state
                if (done) begin
                    out_byte <= data;
                end else begin
                    out_byte <= 8'b0; // Don't care when not done
                end
                
            3'b111: // BIT5 state
                data <= {data[6:0], in}; // Append received bit to data              
        endcase
    end
    
    always @(posedge clk) begin
        case (state)
            3'b101: // BIT3 state
                done <= in; // Check stop bit when in BIT3 state
        endcase
    end

endmodule
