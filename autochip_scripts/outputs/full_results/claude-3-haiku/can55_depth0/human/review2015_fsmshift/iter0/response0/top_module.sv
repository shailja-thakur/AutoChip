module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CNT_MAX = 4;
reg [1:0] state;
reg [1:0] next_state;
reg [3:0] cnt;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        cnt <= 0;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        if (state == 0 && cnt < CNT_MAX-1) begin
            cnt <= cnt + 1;
            shift_ena <= 1'b1;
        end
        else begin
            shift_ena <= 1'b0;
            cnt <= 0;
        end
    end
end

always @(*) begin
    case (state)
        0: begin
            next_state = 0;
        end
        default: begin
            next_state = 0;
        end
    endcase
end

endmodule
