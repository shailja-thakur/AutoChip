module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    logic [1:0] next_state;

    // Define states
    localparam IDLE = 2'b00;
    localparam INC1 = 2'b01;
    localparam INC2 = 2'b10;
    localparam MAX = 2'b11;

    // Registers
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            next_state <= IDLE;
        else begin
            case (state)
                IDLE:
                    if (train_valid && train_taken)
                        next_state <= INC1;
                    else if (train_valid && !train_taken)
                        next_state <= IDLE;
                    else
                        next_state <= state;
                INC1:
                    if (train_valid && train_taken)
                        next_state <= INC2;
                    else if (train_valid && !train_taken)
                        next_state <= IDLE;
                    else
                        next_state <= IDLE;
                INC2:
                    if (train_valid && train_taken)
                        next_state <= MAX;
                    else if (train_valid && !train_taken)
                        next_state <= INC1;
                    else
                        next_state <= INC1;
                MAX:
                    if (train_valid && train_taken)
                        next_state <= MAX;
                    else if (train_valid && !train_taken)
                        next_state <= INC2;
                    else
                        next_state <= INC2;
                default:
                    next_state <= IDLE;
            endcase
        end
    end

    // Output assignment
    assign state = next_state;

endmodule
