module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLES = 4;

reg [1:0] state;
localparam RESET = 2'd0,
          ENABLE = 2'd1;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            RESET: begin
                shift_ena <= 1'b1;
                if (CYCLES == 4'd4) begin
                    state <= ENABLE;
                    shift_ena <= 1'b0;
                end
            end
            ENABLE: begin
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
