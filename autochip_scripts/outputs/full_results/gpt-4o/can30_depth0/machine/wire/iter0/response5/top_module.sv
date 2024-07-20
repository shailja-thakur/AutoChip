module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State definitions
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    // Internal signals
    state_t state;
    reg [7:0] counter;

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'd0;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end

                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                    if (counter == 8'd255) begin
                        state <= PROCESS;
                    end
                end

                PROCESS: begin
                    // Replace with the specific data processing logic
                    data_out <= 8'hFF; // Example data
                    state <= DONE;
                end

                DONE: begin
                    valid_out <= 1'b1;
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
