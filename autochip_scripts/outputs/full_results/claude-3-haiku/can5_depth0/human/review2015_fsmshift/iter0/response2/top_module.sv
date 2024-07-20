module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam IDLE  = 2'd0,
          ENABLE = 2'd1,
          CNT    = 2'd2;

reg [1:0] state;
reg [1:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        shift_ena <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                if (reset) begin
                    state <= ENABLE;
                    count <= 2'd3;
                end
            end
            ENABLE: begin
                shift_ena <= 1'b1;
                if (count == 0) begin
                    state <= IDLE;
                end
                else begin
                    count <= count - 1;
                end
            end
            default: begin
                state <= IDLE;
                count <= 0;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
