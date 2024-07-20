module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    reg [7:0] received_data;
    reg [2:0] state;
    reg [2:0] next_state;

    // Internal signals
    wire start_bit = (state == 3'b000) ? 1'b0 : 1'b1;
    wire stop_bit = (state == 3'b100) ? 1'b1 : 1'b0;

    // Output signals
    assign out_byte = received_data;
    assign done = stop_bit;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            received_data <= 8'b0;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    state <= (in == 1'b0) ? 3'b001 : 3'b000;
                end
                3'b001: begin // Receiving data bits
                    received_data <= {received_data[6:0], in};
                    state <= (state == 3'b111) ? 3'b010 : 3'b001;
                end
                3'b010: begin // Waiting for stop bit
                    state <= (in == 1'b1) ? 3'b100 : 3'b010;
                end
                3'b100: begin // Done
                    state <= (in == 1'b1) ? 3'b000 : 3'b100;
                end
            endcase
        end
    end
endmodule
