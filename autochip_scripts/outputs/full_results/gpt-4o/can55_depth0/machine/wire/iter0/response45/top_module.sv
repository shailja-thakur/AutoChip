module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Internal signals
    reg [1:0] state;
    reg [3:0] counter;

    // State Encoding
    localparam IDLE = 2'b00,
               WAIT = 2'b01,
               PROCESS = 2'b10,
               DONE = 2'b11;

    // Initial state setup
    initial begin
        state = IDLE;
        counter = 0;
        data_out = 0;
        valid_out = 0;
    end

    // FSM implementation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
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
                    if (counter == 4'b1111) begin // Just an example threshold
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_out <= 8'hFF; // Example data processing
                    state <= DONE;
                end
                DONE: begin
                    valid_out <= 1;
                    state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end

endmodule
