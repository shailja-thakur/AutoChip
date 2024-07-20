module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam WAIT_STATE = 2'd0;
localparam ENABLE_STATE = 2'd1;
localparam DONE_STATE = 2'd2;

reg [1:0] state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_STATE;
        count <= 0;
        shift_ena <= 1'b0;
    end
    else begin
        case (state)
            WAIT_STATE: begin
                shift_ena <= 1'b0;
                count <= 0;
                state <= ENABLE_STATE;
            end
            ENABLE_STATE: begin
                shift_ena <= 1'b1;
                count <= count + 1;
                if (count == 2'd3) begin
                    state <= DONE_STATE;
                end
            end
            DONE_STATE: begin
                shift_ena <= 1'b0;
                count <= 0;
                state <= WAIT_STATE;
            end
            default: begin
                state <= WAIT_STATE;
            end
        endcase
    end
end

endmodule
