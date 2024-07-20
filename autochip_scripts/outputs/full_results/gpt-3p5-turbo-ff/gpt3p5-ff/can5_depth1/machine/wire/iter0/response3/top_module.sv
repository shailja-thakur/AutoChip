module top_module(
    input wire clock,
    input wire reset,
    output wire data_output,
    output wire valid_output
);

reg [1:0] state;
reg [7:0] counter;
reg [7:0] data_output;

// Idle state
always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // idle state
        counter <= 8'h00; // reset counter
        data_output <= 8'h00; // reset data output
        valid_output <= 1'b0; // reset valid output
    end else begin
        case(state)
            2'b00: begin // idle state
                counter <= 8'h00; // reset counter
                data_output <= 8'h00; // reset data output
                valid_output <= 1'b0; // reset valid output
                if (in) begin
                    state <= 2'b01; // wait state
                end
            end
            2'b01: begin // wait state
                counter <= counter + 1;
                data_output <= 8'h00; // reset data output
                valid_output <= 1'b0; // reset valid output
                if (counter >= 8'hFF) begin
                    state <= 2'b10; // process state
                end
            end
            2'b10: begin // process state
                data_output <= in;
                valid_output <= 1'b1;
                state <= 2'b11; // done state
            end
            2'b11: begin // done state
                valid_output <= 1'b1;
                if (!in) begin
                    state <= 2'b00; // back to idle state
                end
            end
        endcase
    end
end

endmodule
