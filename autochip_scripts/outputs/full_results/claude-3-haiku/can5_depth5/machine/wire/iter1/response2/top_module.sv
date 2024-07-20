module top_module(
    input clock,
    input reset,
    output reg [31:0] data_out,
    output reg valid
);

reg [1:0] state;
reg [31:0] counter;

always @(posedge clock, posedge reset) begin
    if (reset) begin
        state <= 0;
        counter <= 0;
        data_out <= 0;
        valid <= 0;
    end else begin
        case (state)
            0: begin // Idle state
                counter <= 0;
                data_out <= 0;
                valid <= 0;
                state <= 1;
            end
            1: begin // Wait state
                counter <= counter + 1;
                data_out <= 0;
                valid <= 0;
                if (counter == 10) begin
                    state <= 2;
                end
            end
            2: begin // Process state
                data_out <= 32'h12345678;
                valid <= 1;
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
