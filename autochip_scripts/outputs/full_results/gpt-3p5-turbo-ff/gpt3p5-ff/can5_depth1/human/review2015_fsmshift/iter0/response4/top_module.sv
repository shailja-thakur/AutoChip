module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [3:0] counter;
    reg detection_flag;

    // Synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            shift_ena <= 1'b0;
            detection_flag <= 1'b0;
        end else begin
            if (detection_flag) begin
                counter <= counter + 1;
                if (counter == 4) begin
                    counter <= 0;
                    shift_ena <= 1'b0;
                    detection_flag <= 1'b0;
                end
            end else begin
                counter <= 0;
                shift_ena <= 1'b0;
                if (/* bit pattern detected */) begin
                    detection_flag <= 1'b1;
                    shift_ena <= 1'b1;
                end
            end
        end
    end

endmodule
