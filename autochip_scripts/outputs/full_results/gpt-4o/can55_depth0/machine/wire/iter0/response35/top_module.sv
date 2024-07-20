module top_module (
    input clock,
    input reset,
    output reg [7:0] data_out,
    output reg valid
);

    // State encoding
    reg [1:0] state;
    reg [1:0] next_state;

    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;

    // Counter
    reg [7:0] counter;
    localparam THRESHOLD = 8'd10;

    // Synchronous state and counter update
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
            data_out <= 8'b0;
            valid <= 1'b0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data_out <= 8'b0;
                    valid <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b0;
                    valid <= 1'b0;
                end
                PROCESS: begin
                    data_out <= // Some data processing logic here
                    valid <= 1'b0;
                end
                DONE: begin
                    valid <= 1'b1;
                end
            endcase
        end
    end

    // Next state logic
    always @* begin
        case (state)
            IDLE: begin
                if (reset) 
                    next_state = IDLE;
                else 
                    next_state = WAIT;
            end
            WAIT: begin
                if (counter < THRESHOLD)
                    next_state = WAIT;
                else
                    next_state = PROCESS;
            end
            PROCESS: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
