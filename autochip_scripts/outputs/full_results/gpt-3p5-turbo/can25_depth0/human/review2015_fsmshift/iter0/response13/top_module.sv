module top_module(
    input clk,
    input reset,
    output shift_ena
);
    
    reg [2:0] state;
    reg enable_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            enable_counter <= 0;
        end else begin
            case (state)
                0: begin
                    if (enable_counter < 4) begin
                        enable_counter <= enable_counter + 1;
                        shift_ena <= 1;
                    end else begin
                        enable_counter <= 0;
                        shift_ena <= 0;
                        state <= 1;
                    end
                end
                1: begin
                    enable_counter <= 0;
                    shift_ena <= 0;
                    state <= 0;
                end
            endcase
        end
    end

endmodule
