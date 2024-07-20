module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;
    reg [7:0] data;
    reg stop_received;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else begin
            case (state)
                3'b000: begin // IDLE state
                    if (in == 1'b0)
                        state <= 3'b001; // transition to START_BIT state
                end
                3'b001: begin // START_BIT state
                    state <= 3'b010; // transition to RECEIVE_BITS state
                end
                3'b010: begin // RECEIVE_BITS state
                    data <= {data[6:0], in}; // shift in received bit
                    if (data[7] == 1'b1)
                        state <= 3'b011; // transition to STOP_BIT state
                end
                3'b011: begin // STOP_BIT state
                    if (in == 1'b1) begin
                        stop_received <= 1'b1;
                        state <= 3'b000; // transition to IDLE state
                    end
                end
            endcase
        end
    end

    assign done = stop_received;

endmodule
