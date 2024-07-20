module top_module(
    input wire clk,
    input wire rst,
    output reg [7:0] data_out,
    output reg valid_out
);

// State declaration
typedef enum reg [1:0] {
    IDLE = 2'b00,
    WAIT = 2'b01,
    PROCESS = 2'b10,
    DONE = 2'b11
} state_t;

state_t state, next_state;
reg [15:0] counter;

// Threshold for counter to transition from WAIT to PROCESS
localparam THRESHOLD = 16'd100;

// State transition logic (combinational)
always @(*) begin
    case (state)
        IDLE: begin
            if (rst)
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
        PROCESS: 
            next_state = DONE;
        DONE:
            next_state = IDLE;
        default:
            next_state = IDLE;
    endcase
end

// Sequential logic: state transitions and output logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        counter <= 16'b0;
        data_out <= 8'b0;
        valid_out <= 1'b0;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                counter <= 16'b0;
                data_out <= 8'b0;
                valid_out <= 1'b0;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 8'b0;
                valid_out <= 1'b0;
            end
            PROCESS: begin
                data_out <= /* insert data processing logic here */;
                valid_out <= 1'b0;
            end
            DONE: begin
                valid_out <= 1'b1;
            end
        endcase
    end
end

endmodule
