module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state;
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                2'b00: begin
                    if (j) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (k) begin
                        state <= 2'b00;
                    end else begin
                        state <= 2'b01;
                    end
                end
                default: state <= 2'b00;
            endcase
        end
    end
    
    always @(state) begin
        case(state)
            2'b00: out = 0;
            2'b01: out = 1;
            default: out = 0;
        endcase
    end

endmodule
