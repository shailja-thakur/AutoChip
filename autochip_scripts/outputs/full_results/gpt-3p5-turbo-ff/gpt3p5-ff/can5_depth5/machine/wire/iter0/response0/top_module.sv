module top_module(
    input clk,
    input rst,
    output reg out,
    output reg valid);
    
    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;
    
    // FSM states
    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 0;
            out <= 0;
            valid <= 0;
        end else begin
            case (state)
                IDLE:
                    begin
                        counter <= 0;
                        out <= 0;
                        valid <= 0;
                        
                        if (in) begin
                            state <= WAIT;
                        end
                    end
                WAIT:
                    begin
                        counter <= counter + 1;
                        out <= 0;
                        valid <= 0;
                        
                        if (counter >= 10) begin
                            state <= PROCESS;
                        end
                    end
                PROCESS:
                    begin
                        out <= data;
                        valid <= 1;
                        
                        state <= DONE;
                    end
                DONE:
                    begin
                        out <= 0;
                        valid <= 1;
                        
                        state <= IDLE;
                    end
                default:
                    begin
                        state <= IDLE;
                    end
            endcase
        end
    end
    
endmodule
