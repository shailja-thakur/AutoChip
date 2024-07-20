module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    localparam SHIFT_CYCLES = 4;
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            shift_ena <= 1'b1;
        end
        else begin
            case (state)
                2'b00: begin
                    shift_ena <= 1'b1;
                    state <= state + 1;
                end
                2'b01: begin
                    shift_ena <= 1'b1;
                    state <= state + 1;
                end
                2'b10: begin
                    shift_ena <= 1'b1;
                    state <= state + 1;
                end
                2'b11: begin
                    shift_ena <= 1'b1;
                    state <= 0;
                end
            endcase
        end
    end

endmodule
