module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [1:0] state;
    reg [3:0] counter;

    parameter IDLE = 2'b00;
    parameter SHIFT_ENA = 2'b01;
  
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            shift_ena <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (counter == 3'b100)
                        state <= SHIFT_ENA;
                    else
                        counter <= counter + 1;
                end
                SHIFT_ENA: begin
                    state <= IDLE;
                    counter <= 0;
                end
            endcase
            if (state == SHIFT_ENA)
                shift_ena <= 1'b1;
            else
                shift_ena <= 1'b0;
        end
    end
endmodule
