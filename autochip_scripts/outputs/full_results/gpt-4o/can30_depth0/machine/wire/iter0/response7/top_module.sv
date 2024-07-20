module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;

    // Internal signals
    reg [1:0] state, next_state;
    reg [7:0] counter;

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: next_state = (reset) ? IDLE : WAIT;
            WAIT: next_state = (counter == 8'hFF) ? PROCESS : WAIT;
            PROCESS: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // State update and counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'h00;
            data_out <= 8'h00;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    counter <= 8'h00;
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'hab; // Replace with actual data processing logic if needed
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

endmodule
