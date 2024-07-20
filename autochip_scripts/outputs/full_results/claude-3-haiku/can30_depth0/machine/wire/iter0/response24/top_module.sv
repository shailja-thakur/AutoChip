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
            2'b00: begin // Idle state
                counter <= 0;
                data_out <= 0;
                state <= 2'b01;
            end
            2'b01: begin // Wait state
                counter <= counter + 1;
                data_out <= 0;
                if (counter == 4'b1010) begin
                    state <= 2'b10;
                end
            end
            2'b10: begin // Process state
                data_out <= 8'b10101010;
                state <= 2'b11;
            end
            2'b11: begin // Done state
                valid <= 1;
                state <= 2'b00;
            end
        endcase
    end
end

endmodule
