module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset)
            state <= 2'b0; // Initial state S
        
        else begin
            case (state)
                
                2'b00: begin // State S
                    if (data)
                        state <= 2'b01; // Next state S1
                    else
                        state <= 2'b00; // Next state S
                end
                    
                2'b01: begin // State S1
                    if (data)
                        state <= 2'b11; // Next state S11
                    else
                        state <= 2'b00; // Next state S
                end
                    
                2'b11: begin // State S11
                    if (data)
                        state <= 2'b11; // Next state S11
                    else
                        state <= 2'b10; // Next state S110
                end
                    
                2'b10: begin // State S110
                    if (data)
                        state <= 2'b11; // Next state Done
                    else
                        state <= 2'b00; // Next state S
                end
                    
                default: state <= 2'b00; // Default to initial state S
            endcase
        end
    end
    
    assign start_shifting = (state == 2'b11) ? 1'b1 : 1'b0; // Output is high if state is Done, low otherwise

endmodule
