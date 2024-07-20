module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states
localparam [1:0] WAIT_FOR_ONES = 2'b00,
                 WAIT_FOR_END = 2'b01,
                 ERROR = 2'b10;

// Declare state register
reg [1:0] state, next_state;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_ONES;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        WAIT_FOR_ONES: begin
            if (in == 1'b0) begin
                next_state = WAIT_FOR_ONES;
            end
            else begin
                next_state = WAIT_FOR_END;
            end
        end
        WAIT_FOR_END: begin
            if (in == 1'b0) begin
                next_state = WAIT_FOR_ONES;
            end
            else if (in == 1'b1) begin
                next_state = ERROR;
            end
            else begin
                next_state = WAIT_FOR_END;
            end
        end
        ERROR: begin
            next_state = WAIT_FOR_ONES;
        end
        default: begin
            next_state = WAIT_FOR_ONES;
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    if (reset) begin
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    end
    else begin
        case (state)
            WAIT_FOR_ONES: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
            WAIT_FOR_END: begin
                if (in == 1'b0) begin
                    disc <= 1'b1;
                    flag <= 1'b0;
                    err <= 1'b0;
                end
                else if (in == 1'b1) begin
                    disc <= 1'b0;
                    flag <= 1'b1;
                    err <= 1'b0;
                end
                else begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b0;
                end
            end
            ERROR: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b1;
            end
            default: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
        endcase
    end
end

endmodule
