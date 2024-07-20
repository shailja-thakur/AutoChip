module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states
localparam STATE_IDLE = 3'b000;
localparam STATE_WAIT_1 = 3'b001;
localparam STATE_WAIT_2 = 3'b010;
localparam STATE_WAIT_3 = 3'b011;
localparam STATE_WAIT_4 = 3'b100;
localparam STATE_WAIT_5 = 3'b101;
localparam STATE_WAIT_6 = 3'b110;
localparam STATE_ERROR = 3'b111;

// State register
reg [2:0] state;

// State transitions
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (in == 1'b1) begin
                    state <= STATE_WAIT_1;
                end
                else begin
                    state <= STATE_IDLE;
                end
            end
            STATE_WAIT_1: begin
                if (in == 1'b1) begin
                    state <= STATE_WAIT_2;
                end
                else begin
                    state <= STATE_IDLE;
                end
            end
            STATE_WAIT_2: begin
                if (in == 1'b1) begin
                    state <= STATE_WAIT_3;
                end
                else begin
                    state <= STATE_IDLE;
                end
            end
            STATE_WAIT_3: begin
                if (in == 1'b1) begin
                    state <= STATE_WAIT_4;
                end
                else begin
                    state <= STATE_IDLE;
                end
            end
            STATE_WAIT_4: begin
                if (in == 1'b1) begin
                    state <= STATE_WAIT_5;
                end
                else begin
                    state <= STATE_IDLE;
                end
            end
            STATE_WAIT_5: begin
                if (in == 1'b1) begin
                    state <= STATE_WAIT_6;
                end
                else begin
                    state <= STATE_IDLE;
                end
            end
            STATE_WAIT_6: begin
                if (in == 1'b1) begin
                    state <= STATE_ERROR;
                end
                else begin
                    state <= STATE_IDLE;
                end
            end
            STATE_ERROR: begin
                state <= STATE_ERROR;
            end
            default: begin
                state <= STATE_IDLE;
            end
        endcase
    end
end

// Output logic
always @(posedge clk) begin
    disc <= 1'b0;
    flag <= 1'b0;
    err <= 1'b0;
    case (state)
        STATE_WAIT_5: begin
            disc <= 1'b1;
        end
        STATE_WAIT_6: begin
            flag <= 1'b1;
        end
        STATE_ERROR: begin
            err <= 1'b1;
        end
        default: begin
            // Do nothing
        end
    endcase
end

endmodule
