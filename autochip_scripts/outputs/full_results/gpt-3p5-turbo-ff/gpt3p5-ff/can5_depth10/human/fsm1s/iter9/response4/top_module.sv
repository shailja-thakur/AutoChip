module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
        end
        else begin
            case(state)
                2'b00: begin
                    if (in) begin
                        state <= 2'b01;
                    end
                    else begin
                        state <= 2'b10;
                    end
                end
                2'b01: begin
                    if (in) begin
                        state <= 2'b01;
                    end
                    else begin
                        state <= 2'b00;
                    end
                end
                2'b10: begin
                    if (in) begin
                        state <= 2'b11;
                    end
                    else begin
                        state <= 2'b00;
                    end
                end
                2'b11: begin
                    if (in) begin
                        state <= 2'b10;
                    end
                    else begin
                        state <= 2'b11;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        case(state)
            2'b00: out <= 1'b1;
            2'b01: out <= 1'b0;
            2'b10: out <= 1'b0;
            2'b11: out <= 1'b1;
        endcase
    end
endmodule
