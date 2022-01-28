global class accountBatchSchedule implements Schedulable{

    /* 
        String sch1 = '0 0 * * * ?';
        accountBatchSchedule sqrb1 = new accountBatchSchedule();
        system.schedule('Every Hour', sch1, sqrb1);

        Command that I've run in the developer console to schedule this job(could have been done with a script)
    */
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new accountBatch());
    }
}
