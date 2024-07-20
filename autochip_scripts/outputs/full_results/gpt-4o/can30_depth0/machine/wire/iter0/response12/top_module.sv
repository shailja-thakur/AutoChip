module top_module(
    input clock,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Internal signals
    reg [1:0] state;
    reg [3:0] counter;

    // State encoding
    localparam IDLE = 2'b00,
               WAIT = 2'b01,
               PROCESS = 2'b10,
               DONE = 2'b11;

    // Initial state
    initial begin
        state = IDLE;
        counter = 0;
        data_out = 0;
        valid_out = 0;
    end

    // FSM logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset the state and outputs
            state <= IDLE;
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 0;
                    data_out <= 0;
                    valid_out <= 0;
                    state <= WAIT;
                end

                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 0;
                    if (counter == 4'd10) begin // Example threshold value
                        state <= PROCESS;
                    end
                end

                PROCESS: begin
                    data_out <= 8'hAA; // Example data value
                    state <= DONE;
                end

                DONE: begin
                    valid_out <= 1;
                    state <= IDLE;
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
