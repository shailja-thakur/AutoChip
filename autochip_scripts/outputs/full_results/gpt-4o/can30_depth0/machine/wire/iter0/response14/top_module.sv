module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    parameter IDLE    = 2'b00,
              WAIT    = 2'b01,
              PROCESS = 2'b10,
              DONE    = 2'b11;

    reg [1:0] state, next_state;
    reg [7:0] counter;

    // Sequential logic for state transitions and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= counter; // Example processing, replace with actual data if required
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

    // Combinational logic for next state logic
    always @(*) begin
        case (state)
            IDLE: next_state = reset ? IDLE : WAIT;
            WAIT: next_state = (counter == 8'd10) ? PROCESS : WAIT; // Replace 10 with threshold value
            PROCESS: next_state = DONE;
            DONE: next_state = reset ? IDLE : WAIT;
            default: next_state = IDLE;
        endcase
    end

endmodule
