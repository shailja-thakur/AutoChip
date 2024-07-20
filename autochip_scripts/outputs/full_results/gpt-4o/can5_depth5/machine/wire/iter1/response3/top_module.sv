module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out);

    // Internal signals
    reg [1:0] state;
    reg [3:0] counter;

    // State encoding
    localparam IDLE    = 2'b00,
               WAIT    = 2'b01,
               PROCESS = 2'b10,
               DONE    = 2'b11;

    // State Machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid_out <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 4'b0000;
                    data_out <= 8'b00000000;
                    valid_out <= 0;
                    state <= WAIT;
                end

                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b00000000;
                    valid_out <= 0;
                    if (counter == 4'b1111) begin
                        state <= PROCESS;
                    end
                end

                PROCESS: begin
                    // Example data processing
                    data_out <= 8'hFF; // Substitute with actual data processing logic
                    state <= DONE;
                end

                DONE: begin
                    valid_out <= 1;
                    state <= IDLE; // returning to IDLE
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
