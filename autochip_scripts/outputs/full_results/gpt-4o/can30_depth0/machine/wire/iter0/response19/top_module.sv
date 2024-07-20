module top_module(
    input clk,
    input rst,
    output reg data_out,
    output reg valid_out
);

    // FSM state declarations
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t state;
    reg [15:0] counter;
    parameter THRESHOLD = 100;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 16'd0;
            data_out <= 1'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 16'd0;
                    data_out <= 1'b0;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end

                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 1'b0;
                    valid_out <= 1'b0;
                    if (counter >= THRESHOLD) begin
                        state <= PROCESS;
                    end
                end

                PROCESS: begin
                    data_out <= some_data_processing_function(); // Assume this is defined elsewhere
                    valid_out <= 1'b0;
                    state <= DONE;
                end

                DONE: begin
                    valid_out <= 1'b1;
                    state <= IDLE;
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

    function [31:0] some_data_processing_function;
        // placeholder for data processing logic
        some_data_processing_function = 32'hDEADBEEF;  
    endfunction

endmodule
