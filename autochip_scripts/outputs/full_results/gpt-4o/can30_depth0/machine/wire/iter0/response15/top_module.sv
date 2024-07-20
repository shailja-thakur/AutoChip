module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_output,
    output reg valid_output
);

    // State encoding
    localparam IDLE    = 2'b00,
               WAIT    = 2'b01,
               PROCESS = 2'b10,
               DONE    = 2'b11;

    reg [1:0] state;
    reg [3:0] counter; // 4-bit counter for simplicity, change as needed
    reg [7:0] data;    // Example data; adjust size as needed

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data_output <= 0;
            valid_output <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 0;
                    data_output <= 0;
                    valid_output <= 0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_output <= 0;
                    if (counter == 4'd10) begin // example threshold
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_output <= data; // assuming 'data' is loaded elsewhere
                    state <= DONE;
                end
                DONE: begin
                    valid_output <= 1;
                    state <= IDLE;
                end
                default: begin
                    state <= IDLE; // safety reset
                end
            endcase
        end
    end

    // Stimulus generation placeholder (if necessary)
    // You can add stimulus_gen module instantiation or define it within this module

endmodule
