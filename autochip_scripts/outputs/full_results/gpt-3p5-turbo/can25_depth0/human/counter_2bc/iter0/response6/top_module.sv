module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= 2'b01;
        end else if(train_valid) begin
            case(state)
                2'b00: begin // current state is 0
                    if(train_taken)
                        state <= 2'b01; // increment to 1
                    else
                        state <= 2'b00; // stay at 0
                end
                2'b01: begin // current state is 1
                    if(train_taken)
                        state <= 2'b10; // increment to 2
                    else
                        state <= 2'b00; // decrement to 0
                end
                2'b10: begin // current state is 2
                    if(train_taken)
                        state <= 2'b11; // increment to 3
                    else
                        state <= 2'b01; // decrement to 1
                end
                2'b11: begin // current state is 3
                    if(train_taken)
                        state <= 2'b11; // stay at 3
                    else
                        state <= 2'b10; // decrement to 2
                end
                default: state <= 2'b01; // default to weakly not-taken
            endcase
        end
    end
    
endmodule
