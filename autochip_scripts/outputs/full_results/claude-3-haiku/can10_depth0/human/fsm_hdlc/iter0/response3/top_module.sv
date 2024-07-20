module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states
parameter IDLE = 2'b00, 
          DISC = 2'b01, 
          FLAG = 2'b10, 
          ERR  = 2'b11;

// State register
reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (in) begin
                next_state = DISC;
            end else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            if (in) begin
                if (in) begin
                    next_state = FLAG;
                end else begin
                    next_state = IDLE;
                end
            end else begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            if (in) begin
                next_state = ERR;
            end else begin
                next_state = IDLE;
            end
        end
        ERR: begin
            if (in) begin
                next_state = ERR;
            end else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;
    case (state)
        DISC: begin
            disc = 1;
        end
        FLAG: begin
            flag = 1;
        end
        ERR: begin
            err = 1;
        end
        default: begin
            // do nothing
        end
    endcase
end

// State register update
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

endmodule
