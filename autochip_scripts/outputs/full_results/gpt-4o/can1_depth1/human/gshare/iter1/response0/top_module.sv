module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // 7-bit global branch history register
    reg [6:0] global_history;

    // 128-entry table of two-bit saturating counters
    reg [1:0] PHT [0:127];

    integer i;
    initial begin
        for(i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b01; // initialize to weakly taken (01)
        end
        global_history = 7'b0; // initialize the global history register to 0
    end

    // Saturating counters transition logic
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            global_history <= 7'b0;
            for(i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // initialize to weakly taken (01)
            end
        end else if (train_valid) begin
            // Training logic
            if (train_mispredicted) begin
                global_history <= train_history; // recover the history register
            end

            // Update the PHT based on training information
            case (PHT[train_pc ^ train_history])
                2'b00: PHT[train_pc ^ train_history] <= train_taken ? 2'b01 : 2'b00;
                2'b01: PHT[train_pc ^ train_history] <= train_taken ? 2'b10 : 2'b00;
                2'b10: PHT[train_pc ^ train_history] <= train_taken ? 2'b11 : 2'b01;
                2'b11: PHT[train_pc ^ train_history] <= train_taken ? 2'b11 : 2'b10;
            endcase

            // Update the history register if not mispredicted
            if (!train_mispredicted) begin
                global_history <= {global_history[5:0], train_taken};
            end
        end else if (predict_valid) begin
            // Update the history register for the prediction
            global_history <= {global_history[5:0], predict_taken};
        end
    end

    // Prediction logic
    always @ (*) begin
        predict_history = global_history;
        if (predict_valid) begin
            // Predict using the current state of the PHT entry
            case (PHT[predict_pc ^ global_history])
                2'b00, 2'b01: predict_taken = 0;
                2'b10, 2'b11: predict_taken = 1;
            endcase
        end else begin
            predict_taken = 0; // default prediction if not valid
        end
    end

endmodule
