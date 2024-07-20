module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

//Declare internal wire/reg variables
reg [1:0] next_state;
reg [1:0] current_state;

always @ (posedge clk or posedge areset) begin
    if (areset) begin
        //Reset state machine to state 1
        current_state <= 1;
    end
    else if (train_valid) begin
        //Transition states based on train_taken signal
        case (current_state)
            0: begin
                if (train_taken)
                    next_state <= 1;
                else
                    next_state <= 0;
            end
            
            1: begin
                if (train_taken)
                    next_state <= 2;
                else
                    next_state <= 0;
            end
            
            2: begin
                if (train_taken)
                    next_state <= 3;
                else
                    next_state <= 1;
            end
            
            3: begin
                if (train_taken)
                    next_state <= 3;
                else
                    next_state <= 2;
            end
        endcase
    end
    else begin
        //Stay in current state if train_valid is not asserted
        next_state <= current_state;
    end
end

//Assign next_state to current_state
always @* begin
    current_state <= next_state;
end

//Output the current state
assign state = current_state;

endmodule
