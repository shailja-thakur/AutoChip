module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);
   
/* Declare and initialize signals */
reg [9:0] next_state;
reg [9:0] current_state = state;

/* Define state parameters */
parameter S = 10'b0000000001;
parameter S1 = 10'b0000000010;
parameter S11 = 10'b0000000100;
parameter S110 = 10'b0000001000;
parameter B0 = 10'b0000010000;
parameter B1 = 10'b0000100000;
parameter B2 = 10'b0001000000;
parameter B3 = 10'b0010000000;
parameter Count = 10'b0100000000;
parameter Wait = 10'b1000000000;

/* Transition logic */
assign shift_ena = current_state[B3] | current_state[B2] | current_state[B1] | current_state[B0];

always @* begin
    /* Default outputs */
    B3_next = 1'b0;
    S_next = 1'b0;;
    S1_next = 1'b0;
    Count_next = 1'b0;
    Wait_next = 1'b0;
    
    case (current_state)
        
        /* Define next state logic for each state */
        S: begin
            if (d == 1'b0)
                S_next = 1'b1;
            else if (d == 1'b1)
                S1_next = 1'b1;
        end
        
        S1: begin
            if (d == 1'b0)
                S_next = 1'b1;
        end
        
        S110: begin
            if (d == 1'b0)
                S_next = 1'b1;
        end
        
        Wait: begin
            if (ack == 1'b1)
                Wait_next = 1'b1;
        end
        
        Count: begin
            if (done_counting == 1'b0 || current_state[B3])
                Count_next = 1'b1;
        end
        
        B2: begin
            B3_next = 1'b1;
        end
        
    endcase
    
end

/* Update current state */
always @(posedge clk)
    current_state <= next_state;
    
/* Output logic */
assign done = (current_state == Wait);
assign counting = (current_state == Count);

endmodule
