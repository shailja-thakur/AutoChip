module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid
);

    reg [1:0] state;
    reg [3:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            counter <= 0;
            data_out <= 0;
        end
        else begin
            case (state)
                0: begin // Idle state
                    counter <= 0;
                    data_out <= 0;
                    state <= 1;
                end
                1: begin // Wait state
                    counter <= counter + 1;
                    data_out <= 0;
                    if (counter == 4'd10) begin
                        state <= 2;
                    end
                end
                2: begin // Process state
                    data_out <= 8'hA5; // Example data processing
                    state <= 3;
                end
                3: begin // Done state
                    valid <= 1;
                    state <= 0;
                end
            endcase
        end
    end

endmodule
