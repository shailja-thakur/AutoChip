module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state;
    
    // State values
    parameter OFF = 2'b00;
    parameter ON = 2'b01;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= OFF;
        end else begin
            case (state)
                OFF: begin
                    if (j) begin
                        state <= ON;
                    end else begin
                        state <= OFF;
                    end
                end
                ON: begin
                    if (k) begin
                        state <= OFF;
                    end else begin
                        state <= ON;
                    end
                end
                default: begin
                    state <= OFF;
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            OFF: begin
                out <= 0;
            end
            ON: begin
                out <= 1;
            end
            default: begin
                out <= 0;
            end
        endcase
    end

endmodule
